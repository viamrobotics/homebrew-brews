class Canon < Formula
  desc "CLI utility for managing docker-based, canonical development environments"
  homepage "https://github.com/viamrobotics/canon"
  url "https://github.com/viamrobotics/canon/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "3359476c918afb7b44dab7c2cb8735651bb90a352ae8cc103d12ab3076bdd429"
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
