class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v1.8.0.tar.gz"
  sha256 "991098891766a71b593fa27da37a9239360c9deb1353b6e3b80a5fa6218f1325"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 26
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b8c01c565e037bd2a62a3b38dd4d8dcd5e027a79b1e0d1c889a8c1fc38bb94d4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "58c77fb4054b8a0e336db687cf74b3954f4c082ca828dbcf2126561a770274e5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "118625dbc7465f78d9cf2a0432f3ff2db4e41196f07d13c0ae3d4dd2c9156716"
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
