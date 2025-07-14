package main

import (
	"fmt"
	"notes/internal/config"
	"notes/internal/server"
)

func main() {
	cfg := config.NewConfig()

	fmt.Printf("=== notes Server Configuration ===\n")
	fmt.Printf("Host: %s\n", cfg.Host)
	fmt.Printf("Port: %s\n", cfg.Port)
	fmt.Printf("Database URL: %s\n", cfg.DBDSN)
	fmt.Printf("Database SSL: %s\n", cfg.DBSSL)
	fmt.Printf("Server Timeout: %d seconds\n", cfg.Timeout)
	fmt.Printf("Database Timeout: %d seconds\n", cfg.DBTimeout)
	fmt.Printf("Redis Host: %s\n", cfg.RedisHost)
	fmt.Printf("Redis Port: %s\n", cfg.RedisPort)
	fmt.Printf("Redis Password: %s\n", cfg.RedisPassword)
	fmt.Printf("JWT Secret Key: %s\n", cfg.JWTSecretKey)
	fmt.Printf("=============================\n")

	server, err := server.NewServer(cfg)
	if err != nil {
		fmt.Printf("Ошибка при создании сервера %v\n", err)
		return
	}
	fmt.Printf("Сервер успешно создан\n")
	// Запускаем сервер
	if err := server.Serve(); err != nil {
		fmt.Printf("Ошибка запуска сервера %v\n", err)
		return
	}
	fmt.Printf("Сервер запущен успешно\n")
}
