class Viam < Formula
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.10.0.tar.gz"
  sha256 "f01550857a5b41a57cb387d995a3b0f7918c425ff59ca1f526325349fa86a98e"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"
  desc "Viam CLI for managing robots, modules, orgs, etc. on the Viam platform. (See also: viam-server for running a robot)."

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
