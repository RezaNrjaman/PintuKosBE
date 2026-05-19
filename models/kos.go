package models

type Kos struct {
	ID          int      `json:"id"`
	Name        string   `json:"name"`
	Price       string   `json:"price"`
	Location    string   `json:"location"`
	Description string   `json:"description"`
	Facilities  []string `json:"facilities"`
	WaNumber    string   `json:"wa_number"`
}