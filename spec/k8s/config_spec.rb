RSpec.describe K8s::Config do
  include FixtureHelpers

  describe '#self.load_file' do
    context 'for a typical kubeadm admin.conf' do
      let(:server_cert) { OpenSSL::X509::Certificate.new(fixture('config/kubeadm-apiserver-cert.pem')) }

      subject {
        described_class.load_file(fixture_path('config/kubeadm-admin.conf'))
      }

      it "loads the current context" do
        expect(subject.context).to eq K8s::Config::Context.new(
          cluster: 'kubernetes',
          user: 'kubernetes-admin',
        )
      end

      it "loads the correct cluster" do
        expect(subject.cluster).to eq K8s::Config::Cluster.new(
          server: 'https://192.168.56.11:6443',
          certificate_authority_data: 'LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUN5RENDQWJDZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRFNE1EY3dOVEEyTWpjeE5Gb1hEVEk0TURjd01qQTJNamN4TkZvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBS0V4CjR0ZXN2V1hUV1Z4dlVQdzFwS29NNmE3NFhPRlRTdGF4d0YrcDFMVENUN3JmdlE3Nncwems4c3F1ZEh0MUlMRkgKMnpia1d2b3UrcFlhNUE1YUkxUjlMZk1vSGRPQ2ZUeXBqZmdDVVRzdDl1amxuZ0dmK3M0VFRqRndZMzBvSVNRWQpHaHUvajZBL3gzbWhhQ0psODM2SkhGeTZDTnE1OTk5MU5uMDlDT0RXc0NPbUZ6RHY3K2VaSGZiVzNIMjU1YUpFCm5zS2RHRTJ2ejNSdnVpbmRUUk1FZnhpc1RkRmx1YTZCMWp3MDF2MWRhWlcvek5sSXF6NDRieFJOTmlONFhLVngKeTJqb0dYSDI1aW5udmc4dDQwL1JCSStvamppcU1nQUlRUHVkdVJacW1pYnJMcytDdmtGcUVVWml3cWdWS0ZGQgpwVHQ0dHB5NjVIckZGZVdwcGFjQ0F3RUFBYU1qTUNFd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dFQkFKbGE3ejFWb0dPMmNiL00vK0RJcW1vQit4T2UKY0FJTUJxYTNXZUZQUXZ1N2dFbGh3cTBFRndTQmRtOUp6R0xqVHRxbGZ5ai8veEgwc08wdWt3WS9NTkRhODdsZQpXT1lsZFN3RW5WQXhmVjRvU0U1N2J4ci9NeE1YVnlYRXVDc1VOTFhXbG9SM251Y3hINHQzUFRSV0ZrejRyZ1ZSCk95WUtsL2w4VW9ZQWQ5VytsRHBaa1ZXa2oxbDZXQTJZck5YQVdtZTNnb2xMS3FLSUpZTUhKUlhVbnBHSWN2SHUKWVZDaGxqbjVQMnpubkVrRms5aTVtZjZ0ZDlXNEErc0cwTUJkV3c2bUl0RWRSZmM0MVNQWUgrcUQwZDZaZDNzUwo2ZzRhaXA4Z2dmRG9SbjBDL0FKb3lFVkxRL0ZPdy9ua0NJNnRDSDQ2amZXak0rb2plbFVDSHRMcHFjRT0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=',
        )
      end

      it "loads the correct user" do
        expect(subject.user).to eq K8s::Config::User.new(
          client_certificate_data: 'LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUM4akNDQWRxZ0F3SUJBZ0lJWlFXeXFFQW8yaEF3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB4T0RBM01EVXdOakkzTVRSYUZ3MHhPVEEzTURVd05qSTNNVFphTURReApGekFWQmdOVkJBb1REbk41YzNSbGJUcHRZWE4wWlhKek1Sa3dGd1lEVlFRREV4QnJkV0psY201bGRHVnpMV0ZrCmJXbHVNSUlCSWpBTkJna3Foa2lHOXcwQkFRRUZBQU9DQVE4QU1JSUJDZ0tDQVFFQTBYVWZYNlJnRnVVTGxJcWYKbm4xSkpNM0UvVTZNRUMzVVNNaVRTZUp1dERRL25wVEpVcUxLVXNVTWxCYWtrQ1dueERVTE93RDZvTW5UYmVmVgpkWVp3djIyU3hRRDRiNjd5Yk1ZSVlVdmFYOVVCQ3VvNDdvb2c3RDYraDJ1TWZRNnR4MVZ6Uk85TGIvbCtTeDNsClF4RkJhcC9lUDZ3KzZrc3NWejFReDE2a3pEaE80bkRPZ2g3b2FLUTVpOElIUUhYKzBTUVhITlZyTVRWTjk2aHQKRU5PK0tVZThHRXJvR0JTNktnNlo4MkE4TzBEejVrU2xrMWVVZ054WGQwQldlazkwRFNJcGVkZUxocE1pVnBwTApnUmVmbGloWmxuYWRoNHY0amxrUk9LMTRjS1k1SXdZSzRUdVM3bkpBSWd0blJOa2dXUENNTkRWdXl1R0R2V2U4CnZzMVhCd0lEQVFBQm95Y3dKVEFPQmdOVkhROEJBZjhFQkFNQ0JhQXdFd1lEVlIwbEJBd3dDZ1lJS3dZQkJRVUgKQXdJd0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dFQkFIdkE5bVVxVGZEQ1VuRDBXQUs5Ni9na2VidnVlK0dUMTFMdApYV05RQTZoekN6MHhHck9pSDhGWTNLb3piZ215TTR5VzFwOEkvR29HVzNmSGl2OHVRTVdqZFFIbVBnZVc1cW9VCm54QlBrOXRuZm1RS2E1UGxEQllIdWFVR3owYzBCdW8zdklQbCs3cU91bkh2YUxUbTR5MnBmQ1ZXaFAraHFmSVUKY24weTdsTzlsbEczWU5ZTW01SEpjSFM1SkdZaEh5cm9JclZnN0NORE5Rak9kNVF3ZnRXVnlMMWVJbktzUEVUMApjV0tRMnNPcmZ2R0pIQ0l6R2tjdWhPM09kems5M0QwbnNrNG05OVlZZ3FpdFJqdWtsdldzOXpjd3pxc3hrQWNlCnZEM011Zzk4TFFSQ1Vxcm9CVldXK0JVb2FvTTZJVER3aDV3cDhuMmE3RVNJR052S096dz0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=',
          client_key_data: 'LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFb3dJQkFBS0NBUUVBMFhVZlg2UmdGdVVMbElxZm5uMUpKTTNFL1U2TUVDM1VTTWlUU2VKdXREUS9ucFRKClVxTEtVc1VNbEJha2tDV254RFVMT3dENm9NblRiZWZWZFlad3YyMlN4UUQ0YjY3eWJNWUlZVXZhWDlVQkN1bzQKN29vZzdENitoMnVNZlE2dHgxVnpSTzlMYi9sK1N4M2xReEZCYXAvZVA2dys2a3NzVnoxUXgxNmt6RGhPNG5ETwpnaDdvYUtRNWk4SUhRSFgrMFNRWEhOVnJNVFZOOTZodEVOTytLVWU4R0Vyb0dCUzZLZzZaODJBOE8wRHo1a1NsCmsxZVVnTnhYZDBCV2VrOTBEU0lwZWRlTGhwTWlWcHBMZ1JlZmxpaFpsbmFkaDR2NGpsa1JPSzE0Y0tZNUl3WUsKNFR1UzduSkFJZ3RuUk5rZ1dQQ01ORFZ1eXVHRHZXZTh2czFYQndJREFRQUJBb0lCQVFDKzl5QzJpMkFNSDZHUwpPVnpVRy9mZTlUZ2Zsa2greTduYTdmdlRoZjFXa0xoY05kempXWVpMTmxxRWZheGx1OThjTlJ4YkhFWms1LzI3CkczNXpXekphWldWRjlkK0x1NTVNNjdSaU9NME5TRjlkK3pRU3o1NjZwVzRDZTF5bi9BVVdVdUw0TzQrMHRHeWYKd2M3dmVjRUJuR1g5K1dXWEtSaHhKWGNMZmsrVDNEQlE0c3hmOHlGVklPQnMrcW9tVUxHWnREK3Y2YUsyaGk5Zwp5VXE2aTN4R2k1ejZVMU04VmZGN0pJZWV6Y2EyVXVHeVdaeGZtK2JyQkZnaXZPZmYxVlZFdjRTWnVKc3RDSnAvClJNUEMwb2pEN2ptSjVEci9QbXM1MjdMYm9qK3o4TmV6TmJhZW8xVmlDYmtKVkM5ZmNKcm05SGlVWVM2dHZmRzEKRVl3ZUpXVWhBb0dCQU9wMlByeGFzTWYxSlR1Zk9NcjdMeE04NTh4bVN4RndGcnlzVUhOcVYxeW9mT0N3TjF5cQplVXNIbE92RnRLd2ZmaFJBSVJTWEhiMGI5aG84STZLQWY4ZmxOUmR3eENpbVhWeUs0NUQ2WklRMXg3V3hSUDdaCllQcVZKdFp6cWp2S1pWWENNaWZWdWUyd25tWS90NXlidzd1MUR6VGpqWjZ0QklMNXBKeUhJU1RSQW9HQkFPU3kKMjhYQUpKSDJVaDA5VnlIdkovR3NrbUxaMXE4VkxrSHpaTmtHWkcxalZVRmNDU2NISXFGeE9URWdkcnZGVkJwNwpaVjQ1K2Z2VmJlTnV6Y1cyN1FNT214dUVFcC9CVEhnb2FCdmY5djdxektsMjdpY3p4S0JGZVBpbWk2VEpVS2IzCm9UL3ZQZnhDNWw1QWVpSnFoOTRvVS9wTTQvaDdFclBMWjVJWmNaUlhBb0dBRGRId2VydkJ4ZGVPWFVoU1dheWEKcHNDbFRTZ09icld6c1dWYXpLTE5DWG9vK2ptSTJkNTJqZFNoazVBd3lTQ0dGdjE4dGJEK29NSUFMS1cwMkFSSgpBK2hmeThUcTJ4YUxWRVFmaTlFbWthQjE2Q0ROMTFQSzRwcGVFcS80cmRPTlM1UEp6dzFMQzFhb3o1QWI2NUJHCjVrNlMyZVE3MmNtTEJZbGZpWlp4ZnJFQ2dZQkFBTUk2dklRL2lTVC80OXZQdG1PQ1loNXhwYTlNUG13OHJzWXAKYW4yT2szOFhsSTlIS2RzS1BXcVpFaEhJaVBmNWxWRVFKcitNTi9YUjhYK0s5cCtyL0ZseVFPc0paSXBuRWovWQpsVHhGcVNadndzWHhtSzVOZ0VQVHFxQm9GS01LcDBDc2FPTDdCeW43ZEtYNW5jQzZicVRaNXN6aURHZDJnOVZQCmNPbDFid0tCZ0VSUG5xei9Jc3VhdnFhK1FxWG0wWWRycmd2VXBrU2J1a1hsZFVjSVhWR1ZvSDlaNGVmWXE5TnQKa21LQkduNHB2VVppR3hhNkhtd0hGOVRhUVMwbUI1R2dyQ0haQkZkbVVIS1Z1TTVSMVJwejkvR1owV3Fhd0x5YgpGWnVPV0RUa01YTzFNMG45VVV0K1pITDJ5a1gxc2tGdm1lNDNzZEZTTUNZVGhwV1dKd0tMCi0tLS0tRU5EIFJTQSBQUklWQVRFIEtFWS0tLS0tCg==',
        )
      end
    end
  end

  describe '#self.from_kubeconfig_env' do
    context 'KUBECONFIG points to a single file' do
      it 'reads the file' do
        expect(YAML).to receive(:load_file).with('kubeconfig_path').and_return(current_context: 'foo')
        described_class.from_kubeconfig_env('kubeconfig_path')
      end
    end

    context 'KUBECONFIG points to two files' do
      it 'reads all of the files' do
        expect(YAML).to receive(:load_file).with('kubeconfig_path').and_return(current_context: 'foo')
        expect(YAML).to receive(:load_file).with('kubeconfig2_path').and_return(current_context: 'should not overwrite 1')
        expect(described_class.from_kubeconfig_env('kubeconfig_path:kubeconfig2_path').current_context).to eq 'foo'
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
