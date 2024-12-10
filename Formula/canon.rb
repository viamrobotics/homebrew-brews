class Canon < Formula
  desc "CLI utility for managing docker-based, canonical development environments"
  homepage "https://github.com/viamrobotics/canon"
  url "https://github.com/viamrobotics/canon/archive/refs/tags/v1.1.2.tar.gz"
  sha256 "bf58d898169320092359fc0babfdfe26a876dbf8f7b926a78c22c2a33dbca9a6"
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
