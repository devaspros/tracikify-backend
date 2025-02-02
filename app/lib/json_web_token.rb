module JsonWebToken
  JWT_SECRET = ENV["JWT_SECRET"] || ENV["SECRET_KEY_BASE"]
  ALGORITHM = "HS256"

  class << self
    def encode(payload:)
      payload.reverse_merge!(exp: 7.days.from_now.to_i)

      JWT.encode(payload, JWT_SECRET, ALGORITHM)
    end
  end
end
