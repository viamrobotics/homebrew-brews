class RplidarModule < Formula
  desc "Viam rplidar modular component"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rplidar.git",
    tag:      "v0.1.9",
    revision: "d9165e4410b91de05a10113a1528b9404fe5c9ba"
  license "Apache-2.0"
  head "https://github.com/viamrobotics/rplidar.git", branch: "main"

  depends_on "go" => :build
  depends_on "swig" => :build
  depends_on "jpeg"

  def install
    system "make", "build-module"
    bin.install "bin/rplidar-module"
  end
end
