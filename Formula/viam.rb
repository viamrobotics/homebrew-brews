class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v1.9.0.tar.gz"
  sha256 "2c14fdbca3ae96ecce5c0303de9a15f88300a00b5873aae6d8295bba2bceab3f"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 27
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "90f14bfc6c4301a3953b248c128cbeef520231c805710e1c14f66b4ce40b3e41"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "060e497b6dfd2a3952bbd8a8bff6480432607b6cf3657cc80344ee57c328c74c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ae218b5f7a35c743e855bf2130520b817b675d9f2a5ed6bfd990c7d4bc43270d"
  end

  depends_on "go" => :build

  def install
    with_env(
      TAG_VERSION: version,
    ) do
      system "make", "cli-ci"
    end
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
    generate_completions_from_executable(bin/"viam", "completion")
  end

  test do
    assert_match "Version", shell_output("#{bin}/viam version")
  end
end
