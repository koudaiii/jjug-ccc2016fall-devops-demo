package main

import (
	"net/http"

	"gopkg.in/gin-gonic/gin.v1"
)

func main() {
	r := gin.Default()
	r.GET("/ping", func(c *gin.Context) {
		c.String(http.StatusOK, "pong")
	})

	r.GET("/healthcheck", func(c *gin.Context) {
		c.String(http.StatusOK, "ok")
	})

	r.GET("/appstatus", func(c *gin.Context) {
		c.String(http.StatusOK, "ok")
	})

	r.Run() // listen and serve on 0.0.0.0:8080
}
