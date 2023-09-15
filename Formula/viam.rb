class Viam < Formula
  url "https://github.com/viamrobotics/rdk/archive/f4fe50894438be446d1734a6c86787d36da1e632.tar.gz"
  sha256 "fbed9f6e2b1bddf1ff435a12d142e07cf6ce55d6f20d73103c217c171daf2599"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"
  desc "Viam CLI for managing robots, modules, orgs, etc. on the Viam platform. (See also: viam-server for running a robot)."
  version "0.8.1a"

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
