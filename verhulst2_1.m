function prosek = verhulst2(vreme)
    poslednje=50;
    K=1000;
    K0=2*K;
    p=1;
    r=p;
    t0=0;
    tmax=10;
    h=1/364.9;
    prosek=0;
    ts=linspace(t0, tmax, 3650);
    for t=ts
        if vreme<=t && vreme+5>t
            poslednje=K0/(1+(K0/poslednje-1)*exp(-r*h));
            prosek=prosek+poslednje;
        else
            poslednje=K/(1+(K/poslednje-1)*exp(-r*h));
            prosek=prosek+poslednje;
        end
    end
end