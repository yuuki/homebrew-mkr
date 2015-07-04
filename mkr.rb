require 'formula'

HOMEBREW_MKR_VERSION='0.3.0'
class Mkr < Formula
  homepage 'https://github.com/mackerelio/mkr'
  url "https://github.com/mackerelio/mkr/releases/download/v#{HOMEBREW_MKR_VERSION}/mkr_darwin_amd64.zip"
  sha1 '13edaa8dc69df601d29e964fd822d44b91444c9b'

  version HOMEBREW_MKR_VERSION
  head 'https://github.com/mackerelio/mkr', :using => :git, :branch => 'master'

  if build.head?
    depends_on 'go' => :build
  end

  def install
    if build.head?
      gopath = buildpath/'.go'

      ( gopath/'src/github.com/mackerelio/mkr' ).make_relative_symlink buildpath

      ENV['GOPATH'] = gopath
      system 'make build'

    end

    bin.install 'mkr'
  end
end
