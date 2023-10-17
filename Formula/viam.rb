class Viam < Formula
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.11.0.tar.gz"
  sha256 "69d5e2518151ee0ec00fb6abbc642996200d065eeb3dfc89c281dad541bd5a45"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"
  desc "Viam CLI for managing robots, modules, orgs, etc. on the Viam platform. (See also: viam-server for running a robot)."

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
