class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.87.0.tar.gz"
  sha256 "46b4765eeef92474cf1dc2488da89ba98629b96e41a0133808d8a72c9abab5c7"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 18
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "31cf5cc559066393aab05bf22b874e00696e867891fe8462702966367eee7443"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "511edb6a870e06f7d4c1bd7c542428e2dc375f380d2f628e779112f210887c9b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8b39f5c7818c50a01b6ff7b1fb804bca5569b3d6279063b4396a3d3d86f07552"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
