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
    rebuild 16
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3c1d6991c8feb9c481408a58af7e38a2ee7892665252c43d1fde0b1186c4fe7c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3bd06e371f93ddbd38583d6350a0b8987011e524d4c3c1ed6530ba4397008af0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3d57515569f447924948c06315be156e94ceeb9aa208e1af4b9a80e1285de914"
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
