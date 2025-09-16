class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.93.0.tar.gz"
  sha256 "e42c4113006f9a4d1cb49c01f94d78b24353cbbd01b317c4d8784b0b8d6a2838"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 28
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "bb42cf4886071792d76ba4f244a9dab34e26a0eece67d4c2f7c31980ec58cc5f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b179b07d8830dbc02964a3512f851a77c3f430e59ec84102ea63f565e5c51f45"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "509c892dda2d1f59ffc383bb2753027ff9f6e94c71e895438cd2f2a2806dad9e"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
