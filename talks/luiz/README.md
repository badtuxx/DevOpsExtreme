# Desmistifcando Redes no HashiCorp Nomad

Esse diretório contém os arquivos de suporte utilizados na apresentação
`Desmistifcando Redes no HashiCorp Nomad` realizada durante DevOps Extreme no
dia 13 de agosto de 2021.

## Prerequisitos
- [Vagrant](https://www.vagrantup.com/downloads)
- [VirtualBox](https://www.virtualbox.org/)

## Subindo a infratrutura do demo

1. Rodar o Vagrant a partir dessa pasta para criar a VM
    ```console
    $ vagrant up
    ```

2. Acessar a VM via SSH
    ```console
    $ vagrant ssh
    ```

3. Verificar que o Nomad e o Consul estão rodando
    ```console
    vagrant@ubuntu-focal:~$ nomad nodes status
    ID        DC   Name          Class   Drain  Eligibility  Status
    83f05bfa  dc1  ubuntu-focal  <none>  false  eligible     ready

    vagrant@ubuntu-focal:~$ consul members status
    Node          Address           Status  Type    Build   Protocol  DC   Segment
    ubuntu-focal  10.199.0.10:8301  alive   server  1.10.1  2         dc1  <all>
    ```

4. Acessar as interfaces web do Nomad e do Consul a partir do seu browser
    * [http://10.199.0.10:4646](http://10.199.0.10:4646)
    * [http://10.199.0.10:8500](http://10.199.0.10:8500)

## Rodando os jobs do Nomad

Esse repositório contém jobs de exemplo do Nomad para ilustrar as diferentes
formas possíveis de comunicação de rede. Esses jobs estão na pasta `jobs` que
é montada no caminho `/home/vagrant/jobs` dentro da VM.

```console
vagrant@ubuntu-focal:~$ cd /home/vagrant/jobs
```

### Conexão entre tasks dentro da mesma allocation

O job `example.nomad` roda um container `redis` com um script de ping dentro
da mesma alocação.

```console
vagrant@ubuntu-focal:~/jobs$ nomad run example.nomad
```

Você pode verificar a saída do log da task `ping` pela interface web ou pela
linha de comando.

### Conexão entre allocations com service discovery

O job `petclinic.nomad` roda uma aplicação web de testes chamada
[PetClinic](https://github.com/spring-projects/spring-petclinic). Essa
aplicação precisa de um banco de dados MySQL que pode ser criado com o job
`mysql.nomad` e `mysql-setup.nomad`.


```console
vagrant@ubuntu-focal:~/jobs$ nomad run mysql.nomad
vagrant@ubuntu-focal:~/jobs$ nomad run mysql-setup.nomad
vagrant@ubuntu-focal:~/jobs$ nomad run petclinic.nomad
```

### Conexão de ingress de tráfego externo

Para acessar a aplicação de teste, precisamos fazer o ingress de tráfego
externo. Vamos utilizar o job `traefik.nomad` para realizar essa função.

```console
vagrant@ubuntu-focal:~/jobs$ nomad run traefik.nomad
```

Agora você poderá acessar a aplicação pelo seu browser no endereço
[http://petclinic.feijuca.fun](http://petclinic.feijuca.fun).

### Conxão entre allocations com service mesh

O job `countdash.nomad` demonstra a integração de service mesh com Consul
Connect.

```console
vagrant@ubuntu-focal:~/jobs$ nomad run countdash.nomad
```

Como o Traefik não faz parte do service mesh, é preciso criar um ingress
gateway com o job `ingress-gateway.nomad`.

```console
vagrant@ubuntu-focal:~/jobs$ nomad run ingress-gateway.nomad
```

Agore você poderá acessar o dashboard pelo seu browser no endereço
[http://countdash.feijuca.fun](http://countdash.feijuca.fun).
