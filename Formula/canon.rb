class Canon < Formula
  desc "CLI utility for managing docker-based, canonical development environments"
  homepage "https://github.com/viamrobotics/canon"
  url "https://github.com/viamrobotics/canon/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "cb5bc61aebecad438dbec6c99cc19278ec75072b36e79d90f4d415cdfd190d31"
  head "https://github.com/viamrobotics/canon.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", "-o", "canon", "./"
    bin.install "canon"
  end

  test do
    system "#{bin}/canon", "config"
  end
end
