class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.129.1.tar.gz"
  sha256 "f8ab1404741f64b1576c44cfa388b3a4b0c3e9c9c167276c61d5b597a0e23009"
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
