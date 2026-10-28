class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v1.14.3.tar.gz"
  sha256 "98eedae03898e3199eb0b641d944a06d4b60dc7f094e46fb10f9ab100cea3a54"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 37
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "ad25a13babd5df1589f3d476b4edb00322e1e4d4f89b05f9c50c462ef73c3f58"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8763490f369997e6b741b8bbd561c21f2197d7f7022519dd3fad8178c0a912db"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7f88bbf1f170f8da867e4d8efdb2ee5f516a9d8a2dc6bd288c87d6b2908dc2da"
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
