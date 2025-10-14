class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.97.0.tar.gz"
  sha256 "9162bb92775c76c747e811cc289c8ef846d1af0f463aa39b15a10f87e1d457c7"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 34
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9f3c6ff7ffda9274f434e2398a137aefa3f133d85fe4a2d5b27cff6caa848936"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "05408a86dff805ca533f68fa9bed3ef2e3d54942c9c456f75b1edf596b523b9e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1fc39bf76a665a99fcd1de5f3c94a09e27ac2b922fe548836627b969e5e3c17c"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
