function poslednje=verhulst(vreme)
    poslednje=50;
    K=1000;
    K0=2*K;
    p=1;
    r=p;
    t0=0;
    h=1/364.9;
    tmax=10;
    ts=linspace(t0, tmax, 3650);
    for t=ts;
        if vreme<=t && vreme+5>t
            poslednje=K0/(1+(K0/poslednje-1)*exp(-r*h));
        else
            poslednje=K/(1+(K/poslednje-1)*exp(-r*h));
        end
    end
end