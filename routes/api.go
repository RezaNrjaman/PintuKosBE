package routes

import (
	"pintukos-backend/controllers"
	"pintukos-backend/middleware"

	"github.com/gin-gonic/gin"
)

func SetupRoutes() *gin.Engine {
	r := gin.Default()

	// --- Rute Guest (Bebas Akses Tanpa Login) ---
	r.GET("/api/kos", controllers.GetKosList)
	r.GET("/api/kos/:id", controllers.GetKosDetail)
	
	r.POST("/api/register", controllers.Register) 
	r.POST("/api/login", controllers.Login)       

	// --- Rute Terproteksi (Wajib Login) ---
	protected := r.Group("/api")
	protected.Use(middleware.RequireAuth())
	{
		protected.GET("/favorites/check/:id", controllers.CheckFavorite)
		protected.POST("/favorites/toggle/:id", controllers.ToggleFavorite) 
		protected.GET("/favorites", controllers.GetFavorites)
		
		protected.GET("/profile", controllers.GetProfile)
		
		protected.PUT("/profile", controllers.UpdateProfile) 
		protected.PUT("/security/password", controllers.ChangePassword)
	}
	return r
}