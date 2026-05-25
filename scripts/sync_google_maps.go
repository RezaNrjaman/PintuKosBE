package main

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"
	"net/url"
	"strings"

	"pintukos-backend/config"
)

// Menangkap data dari pencarian awal termasuk koordinat geometry
type PlacesResponse struct {
	Results []struct {
		Name             string  `json:"name"`
		FormattedAddress string  `json:"formatted_address"`
		Rating           float64 `json:"rating"`
		PlaceID          string  `json:"place_id"`
		Geometry         struct {
			Location struct {
				Lat float64 `json:"lat"`
				Lng float64 `json:"lng"`
			} `json:"location"`
		} `json:"geometry"` // Membaca data koordinat langsung dari Text Search
	} `json:"results"`
	Status string `json:"status"`
}

type PlaceDetailsResponse struct {
	Result struct {
		FormattedPhoneNumber string `json:"formatted_phone_number"`
	} `json:"result"`
	Status string `json:"status"`
}

func main() {
	fmt.Println("Mencoba terhubung ke database...")
	config.ConnectDB()

	apiKey := "AIzaSyBN6V5jlX9RWTrAcLtSYAmyYRfk8cIV7_8"

	fmt.Println("Mengambil data kos di sekitar Setiabudi Bandung dari Google Maps...")

	query := url.QueryEscape("kos kosan sekitar setiabudi bandung")
	apiUrl := fmt.Sprintf("https://maps.googleapis.com/maps/api/place/textsearch/json?query=%s&key=%s", query, apiKey)

	resp, err := http.Get(apiUrl)
	if err != nil {
		log.Fatalf("Gagal melakukan HTTP Request: %v", err)
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		log.Fatalf("Gagal membaca hasil response API: %v", err)
	}

	var placesData PlacesResponse
	if err := json.Unmarshal(body, &placesData); err != nil {
		log.Fatalf("Gagal mengurai JSON: %v", err)
	}

	if placesData.Status != "OK" {
		log.Fatalf("API Error. Status: %s.", placesData.Status)
	}

	fmt.Printf("Ditemukan %d tempat. Memulai proses insert...\n\n", len(placesData.Results))

	fmt.Println("Menghapus data kos lama dari database...")
	_, errDelete := config.DB.Exec("TRUNCATE TABLE kos CASCADE")
	if errDelete != nil {
		fmt.Printf("Peringatan: Gagal menghapus data lama: %v\n", errDelete)
	} else {
		fmt.Println("Data lama berhasil dibersihkan! Mulai memasukkan data baru...")
	}
	
	for _, place := range placesData.Results {
		detailUrl := fmt.Sprintf("https://maps.googleapis.com/maps/api/place/details/json?place_id=%s&fields=formatted_phone_number&key=%s", place.PlaceID, apiKey)
		detailResp, errDetail := http.Get(detailUrl)
		
		waNumber := "" 

		if errDetail == nil {
			detailBody, _ := io.ReadAll(detailResp.Body)
			var detailsData PlaceDetailsResponse
			json.Unmarshal(detailBody, &detailsData)

			if detailsData.Result.FormattedPhoneNumber != "" {
				phone := detailsData.Result.FormattedPhoneNumber
				phone = strings.ReplaceAll(phone, " ", "")
				phone = strings.ReplaceAll(phone, "-", "")
				if strings.HasPrefix(phone, "0") {
					phone = "+62" + phone[1:]
				}
				waNumber = phone
			}
			detailResp.Body.Close()
		}

		desc := fmt.Sprintf("Kos strategis sekitar Setiabudi. Diambil otomatis dari Google Maps.")
		
		//  Perubahan: Tambahkan kolom latitude dan longitude ke dalam query SQL
		queryInsert := `
			INSERT INTO kos (name, rating, location, description, wa_number, latitude, longitude) 
			VALUES ($1, $2, $3, $4, $5, $6, $7)
		`
		
		//  Perubahan: Masukkan variabel Lat dan Lng dari koordinat objek geometry Google Maps
		_, errExec := config.DB.Exec(queryInsert, 
			place.Name, 
			place.Rating, 
			place.FormattedAddress, 
			desc, 
			waNumber, 
			place.Geometry.Location.Lat, 
			place.Geometry.Location.Lng,
		)
		
		if errExec != nil {
			log.Printf("[GAGAL] insert kos '%s': %v\n", place.Name, errExec)
		} else {
			fmt.Printf("[SUKSES] %s (Lat: %f, Lng: %f)\n", place.Name, place.Geometry.Location.Lat, place.Geometry.Location.Lng)
		}
	}
	
	fmt.Println("\n[SELESAI] Proses sinkronisasi data koordinat dari Google Maps selesai!")
}