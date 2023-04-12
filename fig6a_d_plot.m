%% Plot Fig 6A-D from Dewey and Shera (2023) JARO
close all;clear;clc;
load Dewey_2023_JARO_figs.mat

panels = [{'a'};{'b'};{'c'};{'d'}]; % panel letters
panelN = length(panels);
locs = [{'BM'}; {'OHC'}; {'TM'}; {'EC'}]; % measurement locations
locN = length(locs);
clrs = [{[28 82 172]/255}; {[237 118 194]/255}; {[255 148 0]/255}; {'r'}]; % plot colors
dp_gen_clr = [148 59 97]/255; % locally generated DP color
st_clr = [.7 .7 .7]; % single-tone color

xlims = [1 9]; % x-limits

% Plot each panel
for p_i = 1:panelN
    panel = panels{p_i};
    loc = locs{p_i}; % location
    clr = clrs{p_i}; % color

    if strcmp(panel, 'd')
        recType = 'mic';
    else
        recType = 'vib';
    end

    f1s = fig6.(genvarname(panel)).(genvarname(loc)).f1s; % f1 (Hz)
    f2s = fig6.(genvarname(panel)).(genvarname(loc)).f2s; % f2
    fdps = 2*f1s-f2s; % DP frequency

    L1s = fig6.(genvarname(panel)).(genvarname(loc)).L1s; % f1 level (dB SPL)
    L2s = fig6.(genvarname(panel)).(genvarname(loc)).L2s; % f2 level
    L1N = length(L1s);

    % Get data
    f2_magC = fig6.(genvarname(panel)).(genvarname(loc)).(genvarname(recType)).f2.magC; % Clean f2 response magnitude (nm or Pa RMS)
    f1_magC = fig6.(genvarname(panel)).(genvarname(loc)).(genvarname(recType)).f1.magC; % Clean f1 response magnitude
    dp_mag = fig6.(genvarname(panel)).(genvarname(loc)).(genvarname(recType)).dp.mag; % DP response magnitude
    dp_magC = fig6.(genvarname(panel)).(genvarname(loc)).(genvarname(recType)).dp.magC; % Clean DP response magnitude
    dp_phi = fig6.(genvarname(panel)).(genvarname(loc)).(genvarname(recType)).dp.phi; % DP response phase (cycles)
    dp_phiC = fig6.(genvarname(panel)).(genvarname(loc)).(genvarname(recType)).dp.phiC; % Clean response DP phase

    % Set up figure
    h = figure('units','normalized','position',[.1+(p_i-1)*.18 .1 .15 .75]);
    ax1 = axes('position', [.15 .71 .8 .15],'FontSize',15,'LineWidth', 1.4, 'box','off'); hold on;
    ax2 = axes('position', [.15 .54 .8 .15],'FontSize',15,'LineWidth', 1.4, 'box','off'); hold on;
    ax3 = axes('position', [.15 .34 .8 .182],'FontSize',15,'LineWidth', 1.4, 'box','off'); hold on;
    ax4 = axes('position', [.15 .17 .8 .15],'FontSize',15,'LineWidth', 1.4, 'box','off'); hold on;

    axes(ax1); % f2 magnitude
    xlim(xlims); set(gca,'Xscale','log','Xtick',[1 2 5 9]);
    ax1.XAxis.Visible = 'off';
    ax1.YAxis.TickLength = [.02 .02];

    if strcmp(panel,'d')
        ylim([27 73]);
    else
        ylim([-16 30]);
    end

    set(gca,'Ytick',-100:20:100);
    ax1.YAxis.MinorTick = 'on';
    ax1.YAxis.MinorTickValues = -100:10:100;

    if p_i<4 && p_i>1
        set(gca,'YTickLabels',' ');
    end

    % ratio axis
    pos = get(ax1,'position');
    pos(2) = pos(2) + .01;
    ax6 = axes('position',pos, 'box','off','LineWidth', 1.4, 'FontSize', 15,'Color','none','XAxisLocation', 'top','Color', 'none'); hold on;
    ax6.XAxis.TickLength = [.015 .015];  
    xlim(xlims); set(gca,'Xscale','log','TickDir','out','Xtick',[1	2.25	3.857142857	6	9],'XMinorTick','off','XTickLabels',[])
    ax6.YAxis.Visible = 'off';
    ax6.XAxis.MinorTick = 'on';
    ax6.XAxis.MinorTickValues = [1 1.59 2.25 3 3.86 4.85 6 7.36 9];

    axes(ax2);  % f1 magnitude
    xlim(xlims); set(gca,'Xscale','log','Xtick',[1 2 5 9]);
    ax2.XAxis.Visible = 'off';

    if strcmp(panel,'d')
        ylim([27 73]);
    else
        ylim([-21 25]);
    end
    
    set(gca,'Ytick',-100:20:100);
    ax2.YAxis.MinorTick = 'on';
    ax2.YAxis.MinorTickValues = -100:10:100;
    ax2.YAxis.TickLength = [.02 .02];

    if p_i<4 && p_i>1
        set(gca,'YTickLabels',' ');
    end

    axes(ax3); % DP magnitude
    xlim(xlims); set(gca,'Xscale','log','Xtick',[1 2 5 9]);
    ax3.XAxis.Visible = 'off';

    if strcmp(loc,'EC')
        ylim([-16.5 37.5]);
    else
        ylim([-41.5 12.5]);
    end

    set(gca,'Ytick',-100:20:100);
    ax3.YAxis.MinorTick = 'on';
    ax3.YAxis.MinorTickValues = -100:10:100;
    ax3.YAxis.TickLength = [.02 .02];
    if p_i<4 && p_i>1
        set(gca,'YTickLabels',' ');
    end
    
    axes(ax4); % DP phase
    xlim(xlims); set(gca,'Xscale','log','Xtick',[1 2 5 9]);
    ax4.XAxis.Visible = 'off'; 
    
    ylim([-5 0.5]); set(gca,'Ytick',-6:2:2);
    ax4.YAxis.MinorTick = 'on';
    ax4.YAxis.MinorTickValues = -6:1:2;
    ax4.YAxis.TickLength = [.02 .02];

    if p_i<4 && p_i>1
        set(gca,'YTickLabels',' ');
    end
    
    % X-axis
    pos = get(ax4,'position');
    pos(2) = pos(2) - .01;
    ax5 = axes('position',pos, 'box','off','LineWidth', 1.4, 'FontSize', 15,'Color','none'); hold on;
    xlim(xlims); set(gca,'Xscale','log','Xtick',[1 2 5 9]);
    ax5.XAxis.MinorTick = 'on';
    ax5.XAxis.TickLength = [.015 .015];
    ax5.YAxis.Visible = 'off';    
    
    %% Plot
    for L1_i = 1:L1N
        lw = 1 + L1_i*.5; % line width

        axes(ax1); % f2 mag
        if strcmp(loc,'EC')
            plot(fdps/1000, 20*log10(f2_magC(:,L1_i)/2e-5), 'k-', 'LineWidth', lw);     
        else
            plot(fdps/1000, 20*log10(f2_magC(:,L1_i)), 'k-', 'LineWidth', lw);     
        end

        axes(ax2); % f1 mag
        if strcmp(loc,'EC')
            plot(fdps/1000, 20*log10(f1_magC(:,L1_i)/2e-5), '-', 'LineWidth', lw, 'Color', [.7 .7 .7]);       
        else
            plot(fdps/1000, 20*log10(f1_magC(:,L1_i)), '-', 'LineWidth', lw, 'Color', [.7 .7 .7]);       
        end

        axes(ax3); % DP mag
        if strcmp(loc, 'EC')
            plot(fdps/1000, 20*log10(dp_magC(:,L1_i)/2e-5), '-', 'LineWidth', lw, 'Color', clr);

        else
            if L1_i==2 && strcmp(loc,'TM')
                plot(fdps(fdps>4000)/1000, 20*log10(dp_mag(fdps>4000, L1_i)), ':', 'LineWidth', 1.8, 'Color', clr); % Plot data in TM response notch
            end
            
            plot(fdps/1000, 20*log10(dp_magC(:,L1_i)), '-', 'LineWidth', lw, 'Color', clr);
        end

        axes(ax4); % DP phase
        if L1_i==2 && strcmp(loc,'TM')
            plot(fdps(fdps>4000)/1000, dp_phi(fdps>4000, L1_i), ':', 'LineWidth', 1.8, 'Color', clr); % Plot data in TM response notch
        end
        
        plot(fdps/1000, dp_phiC(:,L1_i), '-', 'LineWidth', lw, 'Color', clr);

        % Plot estimated locally generated DP phase and single-tone phase response at 70 dB SPL for comparison
        if L1_i == L1N && ~strcmp(loc,'EC')
            % locally generated DP phase
            dp_gen_phi = fig6.(genvarname(panel)).(genvarname(loc)).(genvarname(recType)).dp_gen.phi;

            % Single-tone response phase
            st_f1s = fig6.(genvarname(panel)).(genvarname(loc)).st_f1s;
            st_phi = fig6.(genvarname(panel)).(genvarname(loc)).(genvarname(recType)).st.phi;

            % Plot
            plot(fdps/1000, dp_gen_phi, '-.', 'LineWidth', 2, 'Color', dp_gen_clr);
            plot(st_f1s/1000, st_phi, '-', 'LineWidth', 2, 'Color', st_clr);
        end
    end
end