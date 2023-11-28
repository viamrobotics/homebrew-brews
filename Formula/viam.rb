class Viam < Formula
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.14.0.tar.gz"
  sha256 "25eef4148b94b856daa46c125d67d9c2cbdd6d393ae0092c72d164a418b8dc8e"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"
  desc "Viam CLI for managing robots, modules, orgs, etc. on the Viam platform. (See also: viam-server for running a robot)."

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
