name?="crab"

#IMAGE_BASENAME=cdci/crab-integral-verification
IMAGE_BASENAME=reanahub/reana-demo-cdci-crab-pulsar-integral-verification
IMAGE=$(IMAGE_BASENAME):$(shell git describe --always --tags)

build:
	docker build code -t $(IMAGE)
	docker tag $(IMAGE) $(IMAGE_BASENAME):latest

push: build
	docker push $(IMAGE)
	docker push $(IMAGE_BASENAME):latest

run:
	reana-client   -lDEBUG   create  -f reana.yaml --name $(name)
	reana-client   -lDEBUG   start --workflow $(name)

run-local:
	cwltool workflow/cwl/crab.cwl --t1 2018-08-29T00:00:00 --t2 2018-09-20T00:00:00 --nscw 15 --chi2_limit 1.2 --systematic_fraction 0.01

validate:
	cat reana.yaml
	reana-client -lDEBUG validate
	cwltool --validate workflow/cwl/*  | grep 'is valid'

download:
	reana-client   -lDEBUG  download --workflow $(name)
	for key in $(shell cat cwl/docker_outdir/cwl.output.json | jq -r 'keys | .[] | select(. | contains("_content"))'); do  \
	    echo "saving $$key"; \
	    cat cwl/docker_outdir/cwl.output.json | jq -cr .$$key | python -c 'import sys, base64; open("'$$key'.png","wb").write(base64.b64decode(sys.stdin.read()))'; \
	done
