class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v999.999.999.tar.gz"
  sha256 "36239478b662c72328b57dba8ebf20b4211f18920bfd3574fd4aefe579de446e"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 12
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c0141bc82c59228adf84fc3ead585c2f4957969119a0a8d5dc742480359e833a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f29c3301b5525123e17d304ab8e789a8c7299b6b4d56e4664101390f2af5a420"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e77c23089f131c9444aefc7af10bf140432e58c800a9606e3d8cdc88d608739c"
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
