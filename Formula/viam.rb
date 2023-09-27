class Viam < Formula
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.9.2.tar.gz"
  sha256 "dd24e144f540b047a883c707055259b380a212bca79784637e68b9f1d32310a6"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"
  desc "Viam CLI for managing robots, modules, orgs, etc. on the Viam platform. (See also: viam-server for running a robot)."

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
