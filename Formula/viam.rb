class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.75.0.tar.gz"
  sha256 "9d7fd23b5ec47dc59fd388475fef22db84b85b7fa86ffe8c6d2692d4933b4daf"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "af6f92b5f6acea24ba7bf5061f3dc400fcfd01fa5cca556d3351d62f3a91ed63"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "482670b0dbd6c20ee9c522b9890df3276cdb40646c2dad8a9b0cea542814d3d8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fe80540b6c33362a30e9d3e3c41213dfff37d724baffea91b503b260527c65b3"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
