
struct LoginVerifyError: Error {
    var message: String?

    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
}
