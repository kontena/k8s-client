RSpec.describe K8s::Config do
  include FixtureHelpers

  describe '#self.load_file' do
    context 'for a typical kubeadm admin.conf' do
      let(:server_cert) { OpenSSL::X509::Certificate.new(fixture('config/kubeadm-apiserver-cert.pem')) }

      subject {
        described_class.from_file(fixture_path('config/kubeadm-admin.conf'))
      }

      it "loads the current context" do
        expect(subject.context).to match hash_including(
          :'cluster' => 'kubernetes',
          :'user' => 'kubernetes-admin'
        )
      end

      it "loads the correct cluster" do
        expect(subject.cluster).to match hash_including(
          :'server' => 'https://192.168.100.100:6443',
          :'certificate-authority-data' => /[a-zA-Z0-9=]+/
        )
      end

      it "loads the correct user" do
        expect(subject.user).to match hash_including(
          :'client-certificate-data' => /[a-zA-Z0-9=]+/,
          :'client-key-data' => /[a-zA-Z0-9=]+/
        )
      end
    end

    context 'for a config with timestamps' do
      subject {
        described_class.load_file(fixture_path('config/with_timestamps.conf'))
      }

      it "does not raise" do
        expect{described_class.load_file(fixture_path('config/with_timestamps.conf'))}.not_to raise_error
      end
    end
  end

  describe '#self.from_kubeconfig' do
    before { stub_const('ENV', { 'KUBECONFIG' => kubeconfig_path } ) }

    context 'KUBECONFIG points to a single file' do
      let(:kubeconfig_path) { 'kubeconfig_path' }

      it 'reads the file' do
        expect(File).to receive(:read).with(File.expand_path(kubeconfig_path)).and_return(YAML.dump('current_context' => 'foo'))
        described_class.from_kubeconfig
      end
    end

    context 'KUBECONFIG points to two files' do
      let(:kubeconfig_path) { 'kubeconfig_path:kubeconfig2_path' }

      it 'reads all of the files' do
        expect(File).to receive(:read).with(File.expand_path('kubeconfig_path')).and_return(YAML.dump('current_context' => 'foo'))
        expect(File).to receive(:read).with(File.expand_path('kubeconfig2_path')).and_return(YAML.dump('current_context' => 'should not overwrite 1'))
        expect(described_class.from_kubeconfig.current_context).to eq 'foo'
      end
    end
  end

  describe '#merge' do
    subject { base.merge(other) }

    context 'clusters' do
      context 'base config and other config define a cluster with the same name' do
        let(:base) { described_class.new(clusters: [ { name: 'kubernetes', cluster: { server: 'http://first.example.com:8080' } } ]) }
        let(:other) { described_class.new(clusters: [ { name: 'kubernetes', cluster: { server: 'http://second.example.com:8080' } } ]) }

        it 'does not overwrite the existing one' do
          expect(subject.cluster('kubernetes').server).to eq 'http://first.example.com:8080'
          expect(subject.clusters.size).to eq 1
        end
      end

      context 'base config and other config define two clusters with differents names' do
        let(:base) { described_class.new(clusters: [ { name: 'first', cluster: { server: 'http://first.example.com:8080' } } ]) }
        let(:other) { described_class.new(clusters: [ { name: 'second', cluster: { server: 'http://second.example.com:8080' } } ]) }

        it 'includes both clusters in the outcome' do
          expect(subject.cluster('first').server).to eq 'http://first.example.com:8080'
          expect(subject.cluster('second').server).to eq 'http://second.example.com:8080'
          expect(subject.clusters.size).to eq 2
        end
      end
    end

    context 'contexts' do
      context 'base config and other config define a context with the same name' do
        let(:base) { described_class.new(contexts: [ { name: 'kubernetes', context: { cluster: 'first', user: 'user' } } ]) }
        let(:other) { described_class.new(contexts: [ { name: 'kubernetes', context: { cluster: 'second', user: 'user' } } ]) }

        it 'does not overwrite the existing one' do
          expect(subject.context('kubernetes').cluster).to eq 'first'
          expect(subject.contexts.size).to eq 1
        end
      end

      context 'base config and other config define two contexts with differents names' do
        let(:base) { described_class.new(contexts: [ { name: 'first', context: { cluster: 'first', user: 'user' } } ]) }
        let(:other) { described_class.new(contexts: [ { name: 'second', context: { cluster: 'second', user: 'user' } } ]) }

        it 'includes both contexts in the outcome' do
          expect(subject.context('first').cluster).to eq 'first'
          expect(subject.context('second').cluster).to eq 'second'
          expect(subject.contexts.size).to eq 2
        end
      end
    end

    context 'users' do
      context 'base config and other config define a user with the same name' do
        let(:base) { described_class.new(users: [ { name: 'first', user: { token: 'first' } } ]) }
        let(:other) { described_class.new(users: [ { name: 'first', user: { token: 'second' } } ]) }

        it 'does not overwrite the existing one' do
          expect(subject.user('first').token).to eq 'first'
          expect(subject.users.size).to eq 1
        end
      end

      context 'base config and other config define two users with differents names' do
        let(:base) { described_class.new(users: [ { name: 'first', user: { token: 'first' } } ]) }
        let(:other) { described_class.new(users: [ { name: 'second', user: { token: 'second' } } ]) }

        it 'includes both users in the outcome' do
          expect(subject.user('first').token).to eq 'first'
          expect(subject.user('second').token).to eq 'second'
          expect(subject.users.size).to eq 2
        end
      end
    end

    context 'current context' do
      context 'base config specifies a current context' do
        let(:base) { described_class.new(current_context: 'first') }
        let(:other) { described_class.new(current_context: 'second') }

        it 'config with a current context does not overwrite it' do
          expect(subject.current_context).to eq 'first'
        end
      end

      context 'base config has no current context' do
        let(:base) { described_class.new }
        let(:other) { described_class.new(current_context: 'second') }

        it 'config with a current context sets it' do
          expect(subject.current_context).to eq 'second'
        end
      end
    end
  end

  it 'does not require optional params' do
    subject = described_class.new(
      clusters: [
        {
          name: 'kubernetes',
          cluster: {
            server: 'http://localhost:8080',
            certificate_authority: 'ca.pem',

          }
        }
      ],
      users: [
        {
          name: 'test',
          user: {
            token: 'SECRET',
          }
        }
      ],

      contexts: [
        {
          name: 'test',
          context: {
            cluster: 'kubernetes',
            user: 'test'
          }
        }
      ],
      current_context: 'test'
    )

    expect(subject.context.cluster).to eq 'kubernetes'
    expect(subject.cluster.server).to eq 'http://localhost:8080'
    expect(subject.user.token).to eq 'SECRET'
  end
end
