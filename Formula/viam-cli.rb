class ViamCli < Formula
  version = "v0.8.0"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/#{version}.tar.gz"

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
