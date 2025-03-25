class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.68.0.tar.gz"
  sha256 "c4d519b28011b9cbd05cd63b45cc04040f90bd19b21a443c86e4c5d6806e321f"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 28
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "72741c5ba06d3926fe85383f6fe395ae219aa60168620a680e5be6bf3a5e12a4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "bd66c334b4fc54cf3592259ca05065c7fc71d4eb03585c381a163ec6e9f52fff"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "99f0b488bf523bb54acc1d263e6fdc5165e340f773179f4d41191acc41d644e2"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
