class Viam < Formula
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.8.1.tar.gz"
  sha256 "7d07ddbf51e5fbe855c1b3d5564ef7a1d8fc18519f7917e6f889e11cf8a37206"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"
  desc "Viam CLI for managing robots, modules, orgs, etc. on the Viam platform. (See also: viam-server for running a robot)."

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
