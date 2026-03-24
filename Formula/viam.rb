class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.118.0.tar.gz"
  sha256 "144b907bcb30c7c04ce96300754a43e1158d85d12358183205cdc0e7a255b384"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 62
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3ce3a76fb5ae6f4e2d5210f4bdb807384c95fc76e57e90d9a2e62e9d8fdb571a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7ede28a4347c0aabc75e4e205b5eaf2314b78fe268318fff88d035ebd875eff6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a0a189d69048e0e221d8e4c213c5b5c43902bfbf7af79b43a2354e2315777e35"
  end

  depends_on "go" => :build

  def install
    with_env(
      TAG_VERSION: version,
    ) do
      system "make", "cli-ci"
    end
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end

  test do
    assert_match "Version", shell_output("#{bin}/viam version")
  end
end
