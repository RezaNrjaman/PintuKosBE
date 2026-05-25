package models

type Kos struct {
	ID          int     `json:"id"`
	Name        string  `json:"name"`
	Rating      float64 `json:"rating"`
	Location    string  `json:"location"`
	Description string  `json:"description"`
	WaNumber    string  `json:"wa_number"`
	Latitude    float64 `json:"latitude"`
	Longitude   float64 `json:"longitude"`
}