class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.132.0.tar.gz"
  sha256 "963bb64cb0df3af4ea45aa71efcd738e7667a6c9d940f0cd476db9fa6cbe98da"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 17
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3d0eacfe51a9afdf37bd3902e8bd098e832500d80a13eab2629c3ba0d6a641e7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8516b9b0c237bedd17db48827e6d907eba22136b3631e4f1d033cdc99179d50c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2128347911f82920b2fb6ab16a3e384c23121339d8aa9ab92acbee8ddc0af280"
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
