class Viam < Formula
  url "https://github.com/viamrobotics/rdk/archive/9781684852fd8645c7f3861ac1f1ddfcaeb0d0c9.tar.gz"
  sha256 "ed05e24e528f8ae56a11563d7fd841d6ed35414f7a4eb7b120a144c62ad1e17e"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"
  desc "Viam CLI for managing robots, modules, orgs, etc. on the Viam platform. (See also: viam-server for running a robot)."
  version "0.15.0a"

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
