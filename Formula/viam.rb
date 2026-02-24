class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.115.0.tar.gz"
  sha256 "d8f689694ca8d90466df3bfea53e94be8e60570665b622b874a98fd68027abb2"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 59
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "dd6a01c2dde07951300cd6632c16bbdefec4e71433d284023fae36557b4270f4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3b28a0609fd2314a6c13494045329b42a1dc7e91180b2d3557589b592253349b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b91329cd9d19d15499b917e5c175ded1d3ef821d5130a02faf8d3ac26a577c55"
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
