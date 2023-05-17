class RplidarModule < Formula
  desc "Viam rplidar modular component"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rplidar.git",
    tag:      "v0.1.5",
    revision: "92770167fecf4f2cb16e09046cf9c07f7041f5ab"
  license "Apache-2.0"
  head "https://github.com/viamrobotics/rplidar.git", branch: "main"

  depends_on "go" => :build
  depends_on "swig" => :build

  def install
    system "make", "build-module"
    bin.install "bin/rplidar-module"
  end
end
