class Viam < Formula
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.9.1.tar.gz"
  sha256 "fcc1e791636e10153f84dff10c8c94c72e2f7358f86cf9fa3f8be59d23e80ba5"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"
  desc "Viam CLI for managing robots, modules, orgs, etc. on the Viam platform. (See also: viam-server for running a robot)."

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
