class Canon < Formula
  desc "CLI utility for managing docker-based, canonical development environments"
  homepage "https://github.com/viamrobotics/canon"
  url "https://github.com/viamrobotics/canon/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "7b6adc8ac623395082517b0fd9cf971fc92f29ef337d1f86b78d364e7decda87"
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
