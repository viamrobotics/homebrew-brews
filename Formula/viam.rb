class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.83.0.tar.gz"
  sha256 "0da9ad77f5a5e8349baef76f79d5c53564a6737675d1db98ee91375b2c7eca4b"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 13
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ba42ad6243fd3a9d8ca9b3237c453408cbe4cf728aa0da53ee6bbf648ca5675e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "02675be764592bc89a44ff453bc0b534dfe62d777f20b81408e20bf4d78660d8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2f7302610bc5e895203bc9cd266c48d8fde36f31fe4eff217de132d8419df71a"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
