variable "security-rules" {
    type = list(object({
        name = string
        priority = number
        direction = string
    }))
}