class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v1.12.0.tar.gz"
  sha256 "59e83a6ac9dc1d0cc7517c5e5766c4d03eed71296d7724a78c3f6c3d61594ae4"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 33
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "e23bf2ec5eea775b7b133a7db3075e391e6d9b67de8e22e246e9ef10d6377d2f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a5c8d98d39e9e0a0e04dc9751cdbc83fd4abd6c67d5f4837d2e4e08f3c3d044a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "77edc039aa3c0d8a73391433f2c60068f28a9d4c568db37fb7db92b7cce1846d"
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
