%% Plot Fig 9A-D from Dewey and Shera (2023) JARO
close all;clear;clc;
load Dewey_2023_JARO_figs.mat

panels = [{'a'};{'b'};{'c'};{'d'}]; % panel letters
panelN = length(panels);
locs = [{'BM'};{'OHC'};{'TM'};{'EC'}]; % measurement locations
locN = length(locs);
clrs = [{[28 82 172]/255}; {[237 118 194]/255}; {[255 148 0]/255}; {'r'}]; % plot colors
lws = [1.3 1.6 1.9 2.2 2.5 2.8 4.2]; % line widths

% Plot each panel
for panel_i = 1:panelN
    panel = panels{panel_i};
	loc = locs{panel_i}; % location
    clr = clrs{panel_i}; % color

    if strcmp(loc,'EC')
        recType = 'mic';
    else
        recType = 'vib';
    end

    % Get data
    fdps = 2*fig9.(genvarname(panel)).(genvarname(loc)).f1s - fig9.(genvarname(panel)).(genvarname(loc)).f2s; % DP frequency (Hz)
    L1s = fig9.(genvarname(panel)).(genvarname(loc)).L1s; % f1 level (dB SPL)
    magC_ave = fig9.(genvarname(panel)).(genvarname(loc)).(genvarname(recType)).dp.magC_ave; % Ave of clean magnitudes (nm or Pa RMS)
    magC_se = fig9.(genvarname(panel)).(genvarname(loc)).(genvarname(recType)).dp.magC_se; % SE of clean magnitudes
    
    % Set up figure
    h = figure('units','normalized','position',[.1+(panel_i-1)/4.5 .3 .16 .28]);
    ax1 = axes('position', [.15 .1 .8 .7], 'FontSize',15,'LineWidth', 1.4, 'box','off'); hold on;
    xlim([1 9]); set(gca,'XScale','log','Xtick',[1 2 5 9]);
    ax1.XAxis.Visible = 'off';
    ax1.YAxis.TickLength = [.02 .02];

    if strcmp(loc,'EC')
        ylim([-5 42.5]);
    else
        ylim([-35 12.5]);
    end

    if panel_i>1 && panel_i < 4
        set(gca,'YTickLabels',' ');
    end

    % X-axis
    pos = get(ax1,'position');
    pos(2) = pos(2) - .02;
    ax2 = axes('position',pos, 'box','off','LineWidth', 1.4, 'FontSize', 15, 'Color','none'); hold on;
    xlim([1 9]); 
    set(gca,'XScale','log','Xtick',[1 2 5 9]);
    ax2.YAxis.Visible = 'off';

    % Ratio axis
    f2f1ax_pos = ax1.Position;
    f2f1ax_pos(2) = f2f1ax_pos(2) + .02;
    f2f1ax = axes('Position',f2f1ax_pos, 'box','off', 'LineWidth', 1.4, 'FontSize', 15, 'XAxisLocation', 'top','Color', 'none'); hold on;
    f2f1ax.YAxis.Visible = 'off';
    f2f1ax.XAxis.TickLength = [.015 .015];
    xlim([1 9]); 
    set(gca,'Xscale','log','TickDir','out','Xtick',[1 2.25 3.86 6 9],'XMinorTick','off','XTickLabels',[]);
    f2f1ax.XAxis.MinorTick = 'on';
    f2f1ax.XAxis.MinorTickValues = [1 1.59 2.25 3 3.86 4.85 6 7.36 9];

    % Plot data for each level
    axes(ax1);
    for L_i = [1 3 4 5 7]
        L1 = L1s(L_i); % stimulus level
        if L1==60
            lsty = '--'; % line style
        else
            lsty = '-';
        end

        lw = lws(L_i); % line width

        % Plot Ave and SE
        if strcmp(loc,'EC') % Ear canal DPOAE (dB SPL)
            plot(fdps/1000, 20*log10(magC_ave(:,L_i)/2e-5), 'LineStyle', lsty, 'LineWidth', lw, 'Color', clr);
            plot(fdps/1000, 20*log10((magC_ave(:,L_i) + magC_se(:,L_i))/2e-5), '-.', 'LineWidth', .8, 'Color', clr);
            plot(fdps/1000, 20*log10((magC_ave(:,L_i) - magC_se(:,L_i))/2e-5), '-.', 'LineWidth', .8, 'Color', clr);

        else  % DP vibration magnitude (dB re 1 nm)
            if L1==55 && strcmp(loc,'TM') % Plot ave data in notch where fewer than half of mice had clean data
                magC_ave_minN_not_satisfied = fig9.(genvarname(panel)).(genvarname(loc)).(genvarname(recType)).dp.magC_ave_minN_not_satisfied(:,L_i);
                plot(fdps(fdps>4000)/1000, 20*log10(magC_ave_minN_not_satisfied(fdps>4000)), ':', 'LineWidth', 1, 'Color', clr);
            end

            plot(fdps/1000, 20*log10(magC_ave(:,L_i)), 'LineStyle', lsty, 'LineWidth', lw, 'Color', clr);
            plot(fdps/1000, 20*log10(magC_ave(:,L_i) + magC_se(:,L_i)), '-.', 'LineWidth', .8, 'Color', clr);
            plot(fdps/1000, 20*log10(magC_ave(:,L_i) - magC_se(:,L_i)), '-.', 'LineWidth', .8, 'Color', clr);
        end
    end
end