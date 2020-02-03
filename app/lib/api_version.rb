class ApiVersion
  attr_reader :version, :default

  def initialize(version, default = false)
    @version = version
    @default = default
  end

  # Memeriksa apakah versi ditentukan atau default
  def matches?(request)
    check_headers(request.headers) || default
  end

  private

  def check_headers(headers)
    # Memeriksa versi dari header yang diterima. Harapkan jenis media kustom `todos`
    accept = headers[:accept]
    accept && accept.include?("application/vnd.todos.#{version}+json")
  end
end