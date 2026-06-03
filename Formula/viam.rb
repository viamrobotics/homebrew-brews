class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.129.2.tar.gz"
  sha256 "ec88f26901271c3fc6866e772de9106e94cc9ea66cb24101bad927de8cf4d8d3"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 13
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "814a25452733edff3b10339de4b162e418022d91642bffcbfdc2f5f7b5303599"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6244835da51e9f8b7a1db1381a1f660f3d47ac1cf21df66e6115380bc2e4fb82"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3bd3bba84959949f5077b421f0d3407859e159ab9e95ff54a4a1d25e0bb7a395"
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
