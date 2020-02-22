function [ r ] = FalsePositionPartA( u, l, N, eps_step, eps_abs )
    
fu = exp(-(u))-3;
fl = exp(-(l))-3;
y = @(x) exp(-x)-3;
    % Check that that neither end-point is a root
    % and if f(a) and f(b) have the same sign, throw an exception.
    if ( fu == 0 )
	r = u;
	return;
    elseif ( fl == 0 )
	r = l;
	return;
    elseif ( fu * fl > 0 )
        disp('Error'); 
    end

    c_old = Inf;

    for k = 1:N
        % Find the false position
        c = l -((u*fl - l*fl)/(fu - fl));
        fc = exp(-(c))-3;

        % Check if we found a root or whether or not
        % we should continue with:
        %          [a, c] if f(a) and f(c) have opposite signs, or
        %          [c, b] if f(c) and f(b) have opposite signs.

        if ( fc == 0 )
            r = c;
            return;
        elseif ( fc*fu < 0 )
            l = c;
        else
            u = c;
        end

        % If |b - a| < eps_step, check whether or not
        %       |f(a)| < |f(b)| and |f(a)| < eps_abs and return 'a', or
        %       |f(b)| < eps_abs and return 'b'.

        if ( abs( c - c_old ) < eps_step )
            if ( abs( fu ) < abs( fl ) && abs( fu ) < eps_abs )
                r = u;
                return;
            elseif ( abs( fl ) < eps_abs )
                r = l;
                return;
            end
        end

	c_old = c;
    end
    figure();
    gride on;
    plot(y);
    error( 'the method did not converge' );
end