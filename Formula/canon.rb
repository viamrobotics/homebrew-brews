class Canon < Formula
  desc "CLI utility for managing docker-based, canonical development environments"
  homepage "https://github.com/viamrobotics/canon"
  url "https://github.com/viamrobotics/canon/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "29a372fc5c6568b81029dc1451dca9877f0415ffda66989a78ffcb9f260d4235"
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
