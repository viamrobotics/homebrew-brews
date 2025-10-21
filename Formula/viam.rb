class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.98.0.tar.gz"
  sha256 "d1af4f469adf28a97ac701757a32d2254e258bf93105bb792bf4a67e53eda090"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 35
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "38e5ca6f61dc48f8a94c0d4124f21cc5de290d04b9e5b9c2880748b3361959dc"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4b02a23f9fc96baf609cf8d5c272425dbd8124979fe632817b033ca791ccaef4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2d9db6abea6038a6e39de401ce33631201569454259c7a7c2b66655e0ed5cd2a"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
