class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.85.0.tar.gz"
  sha256 "d2728b14cf8c221fd0e76a963c9e1a2dc1cdbbc35feeb1fde0bb8a6a6ed8a802"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 14
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "86267084c8f4f721927f1b4d44e189baa6b375a7dacf3b39e3528c5de9e8fb66"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2d6509a138b203f9e88c0442bacae409e3618cd709da1e9f4efe698676f0373a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3bbd19e13561a9fee15ab8a68cc1a9944becdc8d0cb0f75e500ab43929978511"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
