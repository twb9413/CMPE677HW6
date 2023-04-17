% Define the range of r values
r = linspace(-6,6,1000);

% Define the transmitted signals
s = [-1 1];

% Define the noise powers
noise_powers = [2 1 0.3];

% Define the signal power
signal_power = 1;

% Initialize the figure
figure;

% Loop over the noise powers
for i = 1:length(noise_powers)
    
    % Compute the variance of the noise
    noise_var = noise_powers(i);
    
    % Compute the signal-to-noise ratio (SNR)
    snr = 10*log10(signal_power/noise_var);
    
    % Compute the conditional probability distributions
    p_r_given_s_neg1 = normpdf(r, -1, sqrt(noise_var));
    p_r_given_s_pos1 = normpdf(r, 1, sqrt(noise_var));
    
    % Plot the conditional probability distributions
    subplot(3,1,i);
    area(r, p_r_given_s_pos1.*(r<=0), 'FaceColor', 'b', 'FaceAlpha', 0.2);
    hold on;
    area(r, p_r_given_s_neg1.*(r>0), 'FaceColor', 'r', 'FaceAlpha', 0.2);
    plot(r, p_r_given_s_neg1, 'r', 'LineWidth', 2);
    plot(r, p_r_given_s_pos1, 'b', 'LineWidth', 2);
    xlabel('r');
    ylabel('p(r|s)');
    title(sprintf('Noise Power = %g, SNR = %g dB', noise_var, snr));
    legend('p(r|s=-1)','p(r|s=+1)','P(class. error)');
    
end

figure

% Define the range of SNR values in dB
SNR_dB = -3:13;

% Calculate the corresponding SNR values
SNR = 10.^(SNR_dB/10);

% Define the probability of symbol error for each SNR value
P_error = 0.5*erfc(sqrt(SNR));

% Define the probability of bit error for each SNR value
P_bit_error = @(SNR) 0.5*(1 - normcdf(sqrt(SNR)));

% Calculate the BER for each SNR value
BER = arrayfun(P_bit_error, SNR);

% Plot the BER vs. SNR curve
figure;
semilogy(SNR_dB, BER);
hold on;

% Add stars at the three SNR values from part a
plot(SNR_dB(2), BER(2), 'r*');
plot(SNR_dB(8), BER(8), 'g*');
plot(SNR_dB(14), BER(14), 'b*');

% Label the axes and add a title
xlabel('SNR (dB)');
ylabel('Bit Error Rate (BER)');
title('Bit Error Rate vs. SNR');

% Add a legend
legend('BER vs. SNR', 'SNR = 0 dB', 'SNR = 6 dB', 'SNR = 12 dB');






